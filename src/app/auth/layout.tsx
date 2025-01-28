export default function AuthLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center px-4">
      <div className="w-full max-w-[400px]">
        <div className="bg-white rounded-3xl shadow-xl p-8">{children}</div>
      </div>
    </div>
  );
}
