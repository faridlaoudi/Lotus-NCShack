"use client";

import { ColumnDef } from "@tanstack/react-table";
import { MoreHorizontal } from "lucide-react";

// This type is used to define the shape of our data.
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { ArrowUpDown } from "lucide-react";

export type Payment = {
  supplier_id: number;
  supplier_name: string;
  drug_name: string;
  quantity: number;
  prix_gr: string;
  phone: string;
  adresse: string;
};

export const columns: ColumnDef<Payment>[] = [
  {
    accessorKey: "supplier_id",
    header: "Id",
  },
  {
    accessorKey: "supplier_name",
    header: "Name",
  },
  {
    accessorKey: "drug_name",
    header: "Drug name",
  },
  {
    accessorKey: "quantity",
    header: "Quantity",
  },
  {
    accessorKey: "prix_gr",
    header: "Unit price",
  },
  {
    accessorKey: "phone",
    header: "Phone",
  },
  {
    accessorKey: "adresse",
    header: "Adresse",
  },

  {
    id: "actions",
    cell: ({ row }) => {
      const payment = row.original;

      return (
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="ghost" className="h-8 w-8 p-0">
              <span className="sr-only">Open menu</span>
              <MoreHorizontal className="h-4 w-4" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuLabel>Actions</DropdownMenuLabel>
            <DropdownMenuItem
              onClick={() =>
                navigator.clipboard.writeText(payment.drug_name.toString())
              }
            >
              Copy payment ID
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem>View customer</DropdownMenuItem>
            <DropdownMenuItem>View payment details</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      );
    },
  },
];
