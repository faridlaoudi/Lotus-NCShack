"use client";

import { ColumnDef } from "@tanstack/react-table";
import { MoreHorizontal } from "lucide-react";
import { format } from "date-fns";

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
  id: number;
  name: string;
  category: string;
  description: string;
  unit_price: string;
  unit_reduction_price: string;
  reorder_level: number;
  expiration_date: string;
  stock_level: number;
  qte: number;
  room: string;
  last_updated: string;
};

export const columns: ColumnDef<Payment>[] = [
  {
    accessorKey: "name",
    header: "Name",
  },
  {
    accessorKey: "category",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
          className="text-center"
        >
          Category
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
  },
  {
    accessorKey: "unit_price",
    header: () => <div className="text-center">Unit price</div>,
    cell: ({ row }) => {
      const amount = parseFloat(row.getValue("unit_price"));
      const formatted = new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: "USD",
      }).format(amount);

      return <div className="text-center font-medium">{formatted}</div>;
    },
  },
  {
    accessorKey: "unit_reduction_price",
    header: () => <div className="text-center">Unit reduction price</div>,
    cell: ({ row }) => {
      const amount = parseFloat(row.getValue("unit_reduction_price"));
      const formatted = new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: "USD",
      }).format(amount);

      return <div className="text-center font-medium">{formatted}</div>;
    },
  },
  {
    accessorKey: "expiration_date",
    header: "Expiration date",
    cell: ({ row }) =>
      format(new Date(row.original.expiration_date), "yy-MM-dd"),
  },
  {
    accessorKey: "stock_level",
    header: "Stock level",
  },
  {
    accessorKey: "qte",
    header: "Quantity",
  },
  {
    accessorKey: "room",
    header: "Room",
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
                navigator.clipboard.writeText(payment.id.toString())
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
