"use client"

import { redirect } from "next/dist/server/api-utils";
import { useRouter } from "next/navigation";
useRouter

export default function Home() {
  const router= useRouter()
  router.push('/dashboard')
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24"></main>
  );
}
