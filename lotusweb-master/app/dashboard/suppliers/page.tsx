import { Payment, columns } from "@/app/components/suppliers/columns";
import { DataTable } from "@/app/components/suppliers/data-table";
import { apiEndPoint } from "@/app/config/config";

async function getData(): Promise<Payment[]> {
  const key = "listsups";
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
