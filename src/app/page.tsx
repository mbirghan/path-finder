import Link from "next/link";
import { createClient } from "@/utils/supabase-server";
import { LogoutButton } from "@/components/auth/LogoutButton";

export default async function Home() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  return (
    <div className="min-h-screen p-8">
      <div className="max-w-4xl mx-auto">
        <div className="bg-white rounded-lg shadow-sm p-6 mb-8">
          <h1 className="text-2xl font-semibold mb-4">Home</h1>
          {user ? (
            <div className="space-y-4">
              <p className="text-gray-600">
                Logged in as: <span className="font-medium">{user.email}</span>
              </p>
              <p className="text-gray-600">
                Organization:{" "}
                <span className="font-medium">
                  {JSON.stringify(user.app_metadata)}
                </span>
              </p>
              <LogoutButton />
            </div>
          ) : (
            <div className="space-y-4">
              <p className="text-gray-600">You are not logged in.</p>
              <Link
                href="/auth/login"
                className="inline-block bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition-colors"
              >
                Go to Login
              </Link>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
