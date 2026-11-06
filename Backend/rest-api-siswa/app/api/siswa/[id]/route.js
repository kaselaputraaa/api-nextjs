import db from "@/lib/db";
import { NextResponse } from "next/server";

// GET: Mengambil data siswa berdasarkan ID
export async function GET(request, { params }) {
  try {
    const { id } = await params;

    const [rows] = await db.query(
      "SELECT * FROM siswa WHERE id = ?",
      [id]
    );

    if (rows.length === 0) {
      return NextResponse.json(
        {
          status: false,
          message: "Data siswa tidak ditemukan",
        },
        { status: 404 }
      );
    }

    return NextResponse.json({
      status: true,
      message: "Data siswa berhasil ditampilkan",
      data: rows[0],
    });
  } catch (error) {
    console.error("Error GET siswa:", error);

    return NextResponse.json(
      {
        status: false,
        message: "Gagal mengambil data siswa",
      },
      { status: 500 }
    );
  }
}

// PUT: Mengubah data siswa berdasarkan ID
export async function PUT(request, { params }) {
  try {
    const { id } = await params;
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

    const [result] = await db.query(
      `UPDATE siswa
       SET nipd = ?, nama_lengkap = ?, jenis_kelamin = ?,
           alamat = ?, kelas = ?, jurusan = ?
       WHERE id = ?`,
      [nipd, nama_lengkap, jenis_kelamin, alamat, kelas, jurusan, id]
    );

    if (result.affectedRows === 0) {
      return NextResponse.json(
        {
          status: false,
          message: "Data siswa tidak ditemukan",
        },
        { status: 404 }
      );
    }

    return NextResponse.json({
      status: true,
      message: "Data siswa berhasil diubah",
    });
   } catch (error) {
    console.error("Error PUT siswa:", error);

    return NextResponse.json(
      {
        status: false,
        message: "Gagal mengubah data siswa",
        error: error.message,
      },
      { status: 500 }
    );
  }
}

// DELETE: Menghapus data siswa berdasarkan ID
export async function DELETE(request, { params }) {
  try {
    const { id } = await params;

    const [result] = await db.query(
      "DELETE FROM siswa WHERE id = ?",
      [id]
    );

    if (result.affectedRows === 0) {
      return NextResponse.json(
        {
          status: false,
          message: "Data siswa tidak ditemukan",
        },
        { status: 404 }
      );
    }

    return NextResponse.json({
      status: true,
      message: "Data siswa berhasil dihapus",
    });
  } catch (error) {
    console.error("Error DELETE siswa:", error);

    return NextResponse.json(
      {
        status: false,
        message: "Gagal menghapus data siswa",
      },
      { status: 500 }
    );
  }
}