import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import React from "react";
import StatusGood from "../assets/statu-good";

const Status = () => {
  return (
    <Card className="w-full p-7 h-full flex flex-col justify-around">
      <CardHeader>
        <CardTitle>Inventory Status</CardTitle>
      </CardHeader>
      <CardContent className="flex justify-center items-center">
        <div className="flex justify-center items-center flex-col">
          <StatusGood />
          <h1 className="text-green-700 text-center">Good</h1>
        </div>
      </CardContent>
    </Card>
  );
};

export default Status;
