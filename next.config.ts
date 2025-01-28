import type { NextConfig } from "next";

// /api and /app/api are both existing side by side
// however /app/api takes priority over /api
// the FastAPI entry point is /api/ so we need to make sure
// /app/api/route.ts does not exist as it would override the FastAPI routes
// the same goes for /app/api/py/fastapi/route.ts
// this would override the FastAPI routes

// hypothesis about routing behaviour:
// NextJS takes the route from the request
// if it exists in /app/api, it will use that
// if not it will fallback to /api
// FastAPI has one entry point /api/
// so we need to route everything to /api/ that should go to FastAPI
// this is done in the next.config.ts file with the rewrites

const nextConfig: NextConfig = {
  async rewrites() {
    return [
      {
        // We do not need /py here but it is here to make sure that
        // that we do not accidentally override the FastAPI routes
        source: "/api/py/:path*",
        destination:
          process.env.NODE_ENV === "development"
            ? "http://127.0.0.1:8000/api/py/:path*"
            // We need to make sure that app/api/route.ts does not exist
            // Otherwise, it will override the FastAPI routes
            : "/api/",
      },
    ];
  },
};

export default nextConfig;
