import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import React from "react";

interface CardCProps {
  title: string;
  element1: string;
  value1: string;
  element2: string;
  value2: string;
}

const CardC: React.FC<CardCProps> = ({
  title,
  element1,
  value1,
  element2,
  value2,
}) => {
  return (
    <Card className="w-full rounded-xl flex flex-col gap-6">
      <CardHeader>
        <CardTitle>{title}</CardTitle>
      </CardHeader>
      <CardContent className="flex justify-between gap-4 text-left">
        <div className="flex flex-col">
          <span className="font-bold text-lg">{element1}</span>
          <span>{value1}</span>
        </div>
        <div className="flex flex-col">
          <span className="font-bold text-lg">{element2}</span>
          <span>{value2}</span>
        </div>
      </CardContent>
    </Card>
  );
};

export default CardC;
