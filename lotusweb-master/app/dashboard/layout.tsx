"use client";
import React from "react";
import Sidevar from "../component/dashboard/sidebar";
import Navbar from "../component/dashboard/navbar";
import PageContainer from "../component/page-container";
interface LayoutProps {
  children: React.ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
  return (
    <div className="flex justify-between w-screen">
      <div className=" bg-white">
        <Sidevar />
        <div className="flex items-center"></div>
      </div>
      <div className="w-full ">
        <Navbar />
        {children}
      </div>
    </div>
  );
};

export default Layout;
