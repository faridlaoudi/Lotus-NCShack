"use client";
import React, { useEffect, useState } from "react";
import CardC from "../component/dashboard/catd";
import PageContainer from "../component/page-container";
import Inventory from "../component/dashboard/inventory";
import Chart from "../component/dashboard/chart";
import Status from "../component/dashboard/status";
import { apiEndPoint } from "../config/config";

const DashboardPage: React.FC = () => {
  type Content = {
    title: string;
    element1: string;
    value1: string;
    element2: string;
    value2: string;
  };

  const keySuppliers = "numsup";
  const keyMedsold = "medsold";

  const [totalSuppliers, setTotalSuppliers] = useState<string>("");
  const [totalMedsold, setTotalMedsold] = useState<string>("");

  // Fetch data from the endpoints
  useEffect(() => {
    const fetchSuppliers = async () => {
      try {
        const response = await fetch(`${apiEndPoint}${keySuppliers}`);
        const data = await response.json();
        const total = data[0].total.toString();
        setTotalSuppliers(total);
      } catch (error) {
        alert(`Error fetching suppliers data: ${error}`);
      }
    };

    const fetchMedsold = async () => {
      try {
        const response = await fetch(`${apiEndPoint}${keyMedsold}`);
        const data = await response.json();
        const total = data[0].total.toString();
        setTotalMedsold(total);
      } catch (error) {
        alert(`Error fetching medecines data: ${error}`);
      }
    };

    fetchSuppliers();
    fetchMedsold();
  }, []);

  const data: Content[] = [
    {
      title: "My Pharmacy",
      element1: totalSuppliers || "0",
      value1: "Total no of Suppliers",
      element2: "05",
      value2: "Total no of Users",
    },
    {
      title: "Quick Report",
      element1: totalMedsold || "0",
      value1: "Qty of Medicines Sold",
      element2: "Doliprane",
      value2: "Frequently asked Item ",
    },
    {
      title: "Customers",
      element1: "Doliprane",
      value1: "Frequently bought Item",
      element2: "322",
      value2: "Total no of customers",
    },
    {
      title: "Inventory",
      element1: "322",
      value1: "Total no of medecines",
      element2: "23",
      value2: "Meddcines groups",
    },
  ];

  return (
    <div className="p-4">
      <PageContainer>
        <div className="flex flex-col gap-9 h-full">
          <div className="flex flex-col md:flex-row gap-9">
            <div className="flex-1 flex flex-col gap-9">
              <div className="flex flex-col md:flex-row gap-9">
                <CardC {...data[0]} />
                <CardC {...data[1]} />
              </div>
              <div className="flex flex-col md:flex-row gap-9">
                <CardC {...data[2]} />
                <CardC {...data[3]} />
              </div>
            </div>
            <div className="flex-none md:w-1/4 lg:w-1/5 bg-white rounded-md">
              <Inventory />
            </div>
          </div>

          <div className="flex flex-col sm:flex-row gap-9 h-1/2">
            <div className="flex-1 md:w-3/4">
              <Chart />
            </div>
            <div className="flex-1 md:w-1/4">
              <Status />
            </div>
          </div>
        </div>
      </PageContainer>
    </div>
  );
};

export default DashboardPage;
