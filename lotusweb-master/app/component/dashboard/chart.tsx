
"use client"
import React from 'react';
import { Chart as GoogleChart } from 'react-google-charts';
import { Card } from '@/components/ui/card';

const Chart: React.FC = () => {
  const data = [
    ['Month', 'Activity'],
    ['Jan', 100],
    ['Feb', 120],
    ['Mar', 130],
    ['Apr', 90],
    ['May', 150],
    ['Jun', 80],
    ['Jul', 70],
    ['Aug', 160],
    ['Sep', 200],
    ['Oct', 220],
    ['Nov', 210],
    ['Dec', 240],
  ];

  const options = {
    title: 'Activity vs. Actual Sales',
    hAxis: { title: 'Month' },
    vAxis: { title: 'Activity' },
    curveType: 'function',
    legend: { position: 'bottom' },
    backgroundColor: '#eaf4fc',
    series: {
      0: { color: '#007bff' },
    },
    lineWidth: 2,
    pointSize: 5,
  };

  return (
    <Card className="w-full h-full">
      <GoogleChart
        chartType="LineChart"
        width="100%"
        height="400px"
        data={data}
        options={options}
        loader={<div>Loading Chart</div>}
      />
    </Card>
  );
};

export default Chart;
