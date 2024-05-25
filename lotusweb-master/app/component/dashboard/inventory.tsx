import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Droplets, Thermometer } from "lucide-react";
import React from "react";

const Inverntory = () => {
  return (
    <Card className="w-full h-full flex flex-col gap-3">
      <CardHeader>
        <CardTitle>Sensors</CardTitle>
        <CardDescription>Sensors information</CardDescription>
      </CardHeader>
      <CardContent className="flex flex-col gap-10">
        {/* gallery */}
        <div className="flex flex-col gap-5">
          <div className="flex gap-4">
            {" "}
            <h1 className="text-lg font-semibold">Temperature</h1>
            <Thermometer />
          </div>
          <div className="flex justify-center text-4xl text-green-700">10°</div>
        </div>
        <div className="flex flex-col gap-5">
          <div className="flex gap-4">
            {" "}
            <h1 className="text-lg font-semibold">Humidity</h1>
            <Droplets />
          </div>
          <div className="flex justify-center text-4xl text-green-700">50%</div>
        </div>
      </CardContent>
    </Card>
  );
};

export default Inverntory;
