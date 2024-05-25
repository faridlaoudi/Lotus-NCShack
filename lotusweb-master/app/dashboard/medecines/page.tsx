import { Payment, columns } from "@/app/components/medecines/columns";
import { DataTable } from "@/app/components/medecines/data-table";
import { apiEndPoint } from "@/app/config/config";

async function getData(): Promise<Payment[]> {
  const key = "listmeds";
  const response = await fetch(`${apiEndPoint}${key}`);
  if (!response.ok) {
    throw new Error("Failed to fetch data");
  }
  const data: Payment[] = await response.json();
  return data;
}

export default async function Page() {
  const data = await getData();

  return (
    <div className="container mx-auto py-10">
      <DataTable columns={columns} data={data} />
    </div>
  );
}
