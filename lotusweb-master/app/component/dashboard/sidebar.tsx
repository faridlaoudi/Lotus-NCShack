import React, { useState } from "react";
import Logo from "../../icons/logo";
import { MenuSection } from "./menu-section";
import {
  LayoutDashboardIcon,
  TextSearch,
  Construction,
  OptionIcon,
} from "lucide-react";
import { usePathname } from "next/navigation";
import { Menu, X } from "lucide-react"; // Importing hamburger menu and close icons

const Sidevar = () => {
  const [isOpen, setIsOpen] = useState(false);

  const menuItems = [
    {
      title: "Menu",
      list: [
        {
          title: "Dashboard",
          path: "/dashboard",
          icon: <LayoutDashboardIcon />,
        },
        {
          title: "Medecines",
          path: "/dashboard/medecines",
          icon: <TextSearch />,
        },
        {
          title: "Suppliers",
          path: "/dashboard/suppliers",
          icon: <OptionIcon />,
        },
        {
          title: "Inventory",
          path: "/dashboard/inventory",
          icon: <Construction />,
        },
      ],
    },
  ];

  const pathname = usePathname();
  return (
    <>
      <div className="sm:hidden flex justify-between items-center p-4 bg-white">
        <div className="hidden">
          <Logo />
        </div>
        <button
          onClick={() => setIsOpen(!isOpen)}
          className="text-black focus:outline-none"
        >
          {isOpen ? <X size={24} /> : <Menu size={24} />}
        </button>
      </div>
      <div
        className={`sm:w-64 bg-white h-screen flex flex-col px-4 gap-3 fixed sm:relative z-10 transform ${
          isOpen ? "translate-x-0" : "-translate-x-full"
        } sm:translate-x-0 transition-transform duration-300 ease-in-out`}
      >
        <div className="py-6 flex justify-center">
          <Logo />
        </div>
        <div>
          <ul className="w-full">
            {menuItems.map((section) => (
              <MenuSection
                key={section.title}
                section={section}
                activePath={pathname}
              />
            ))}
          </ul>
        </div>
      </div>
      {isOpen && (
        <div
          className="fixed inset-0 bg-black opacity-50 sm:hidden"
          onClick={() => setIsOpen(false)}
        ></div>
      )}
    </>
  );
};

export default Sidevar;
