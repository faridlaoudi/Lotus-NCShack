import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { BellIcon } from "lucide-react";
import React from "react";

const Navbar = () => {
  const user = "User";
  const staticUserName = "John Doe"; // Static user name
  const staticUserInitials = "JD"; // Static user initials

  return (
    <div className="w-full px-5 py-7 flex justify-between items-center">
      <div className="flex justify-center gap-1 flex-col">
        <h1 className="text-3xl font-bold">Hello {user}</h1>
        <p className="text-gray-500">
          This is a description, idk what I should put
        </p>
      </div>
      <div className="flex items-center gap-4">
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button className="text-foreground bg-transparent">
              <BellIcon />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent className="w-56 cursor-pointer bg-card">
            <DropdownMenuItem>Notification 1</DropdownMenuItem>
            <DropdownMenuItem>Notification 2</DropdownMenuItem>
            <DropdownMenuItem>Notification 3</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>

        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <div className="flex items-center cursor-pointer">
              <div className="flex gap-2 items-center bg-[#F2F5FD] rounded-full pr-4 text-[#556476]">
                <Avatar className="w-10 h-10 rounded-full">
                  <AvatarFallback className="w-full h-full rounded-full flex items-center justify-center bg-[#4A58EC] text-white font-bold text-sm uppercase">
                    {staticUserInitials}
                  </AvatarFallback>
                </Avatar>
                <span className="text-[#556476] gap-4 text-[17px] font-[600] hidden lg:block">
                  {staticUserName}
                </span>
              </div>
            </div>
          </DropdownMenuTrigger>
          <DropdownMenuContent className="w-56 cursor-pointer bg-card">
            <DropdownMenuItem>Profile</DropdownMenuItem>
            <DropdownMenuItem>Settings</DropdownMenuItem>
            <DropdownMenuItem className="text-destructive">
              Logout
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
    </div>
  );
};

export default Navbar;
