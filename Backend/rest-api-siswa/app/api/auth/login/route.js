
import db from "@/lib/db";
import { NextResponse } from "next/server";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";


// Menangani CORS Preflight
export async function OPTIONS() {
  return new Response(null, {
    status: 204,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type, Authorization",
    },
  });
}


// Samakan secret dengan middleware verifyToken yang lama
const JWT_SECRET = "12RPLSQUAT";

// POST: Login user
export async function POST(request) {
  try {
    const body = await request.json();

    const { email, password } = body;

    // Validasi input
    if (!email || !password) {
      return NextResponse.json(
        {
          status: false,
          message: "Email dan password wajib diisi",
        },
        { status: 400 }
      );
    }

    // Cari user berdasarkan email
    const [rows] = await db.query(
      "SELECT * FROM users WHERE email = ?",
      [email]
    );

    if (rows.length === 0) {
      return NextResponse.json(
        {
          status: false,
          message: "Email atau password salah",
        },
        { status: 401 }
      );
    }

    const user = rows[0];

    // Cocokkan password dengan hash bcrypt
    const passwordCocok = await bcrypt.compare(
      password,
      user.password
    );

    if (!passwordCocok) {
      return NextResponse.json(
        {
          status: false,
          message: "Email atau password salah",
        },
        { status: 401 }
      );
    }

    // Buat JWT token
    const token = jwt.sign(
      {
        id: user.id,
        email: user.email,
      },
      JWT_SECRET,
      {
        expiresIn: "1h",
      }
    );

    // Kirim respons ke Flutter
    return NextResponse.json({
      status: true,
      message: "Login berhasil",
      token: token,
      data: {
        id: user.id,
        nama: user.nama,
        email: user.email,
      },
    });

  } catch (error) {
    console.error("Error Login:", error);

    return NextResponse.json(
      {
        status: false,
        message: "Gagal melakukan login",
        error: error.message,
      },
      { status: 500 }
    );
  }
}
