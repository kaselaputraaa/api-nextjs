import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET() {
  try {
    const [rows] = await db.query("SELECT * FROM siswa");

    return NextResponse.json({
      status: true,
      message: "Data siswa berhasil ditampilkan",
      data: rows,
    });
  } catch (error) {
    console.error("Error GET siswa:", error);

    return NextResponse.json(
      {
        status: false,
        message: "Gagal mengambil data siswa",
        error: error.message,
      },
      { status: 500 }
    );
  }
}


export async function POST(request) {
  try {
    const body = await request.json();

    const {
      nipd,
      nama_lengkap,
      jenis_kelamin,
      alamat,
      kelas,
      jurusan,
    } = body;

    if (
      !nipd ||
      !nama_lengkap ||
      !jenis_kelamin ||
      !alamat ||
      !kelas ||
      !jurusan
    ) {
      return NextResponse.json(
        {
          status: false,
          message: "Semua data siswa wajib diisi",
        },
        { status: 400 }
      );
    }

    const sql = `
      INSERT INTO siswa
      (nipd, nama_lengkap, jenis_kelamin, alamat, kelas, jurusan)
      VALUES (?, ?, ?, ?, ?, ?)
    `;

    const [result] = await db.query(sql, [
      nipd,
      nama_lengkap,
      jenis_kelamin,
      alamat,
      kelas,
      jurusan,
    ]);

    return NextResponse.json(
      {
        status: true,
        message: "Data siswa berhasil ditambahkan",
        id: result.insertId,
      },
      { status: 201 }
    );
  } catch (error) {
    console.error("Error POST siswa:", error);

    return NextResponse.json(
      {
        status: false,
        message: "Gagal menambahkan data siswa",
      },
      { status: 500 }
    );
  }
}