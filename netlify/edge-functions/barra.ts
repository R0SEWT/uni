// Agrega la barra final a las rutas de carpeta: /concurrente → /concurrente/.
//
// Las entregas se montan con un proxy (ver sitio/_redirects) y sus páginas usan enlaces relativos
// (pc3/, index_files/…). Sin la barra final, el navegador los resuelve contra la carpeta de arriba
// y se rompen. No se puede hacer en _redirects: Netlify compara las rutas sin mirar la barra final,
// así que una regla /x → /x/ entraría en bucle.
//
// Los archivos (la última parte de la ruta tiene un punto: .pdf, .mp4, .css…) pasan sin tocar.
import type { Config, Context } from "https://edge.netlify.com";

export default async (req: Request, context: Context) => {
  const url = new URL(req.url);
  const ultima = url.pathname.split("/").pop() ?? "";
  if (url.pathname.endsWith("/") || ultima.includes(".")) return context.next();
  url.pathname += "/";
  return Response.redirect(url.toString(), 301);
};

export const config: Config = { path: "/*", excludedPath: ["/"] };
