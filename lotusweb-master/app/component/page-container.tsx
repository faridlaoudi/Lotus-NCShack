import React from "react";
interface LayoutProps {
  children: React.ReactNode;
}

const PageContainer = ({ children }: { children: React.ReactNode }) => {
  return <div className="px-10">{children}</div>;
};

export default PageContainer;
