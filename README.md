# uni

Catálogo de las entregas de la universidad en **<https://uni.rosewt.dev>**, con una ruta por curso
y entrega: `uni.rosewt.dev/<curso>/<entrega>/`.

Este repo no guarda las entregas. Cada una se publica desde el repo de su curso, en su propio sitio
de Netlify (su «origen»), y aquí se monta con un proxy: la dirección del navegador no cambia. Así,
publicar la PC4 no toca este repo, y este repo no carga 15 MB por deck.

## Qué hay montado

| Ruta | Curso | Origen (sitio de Netlify) | Se publica desde |
|---|---|---|---|
| `/concurrente/` | Programación Concurrente y Distribuida (1ACC0065) | `concurrente-rosewt` | `aire-distribuido/docs/presentacion/publicar.sh` |
| `/cs-topics/tb1/` | Tópicos en Ciencias de la Computación (1ACC0058), TB1 | `kenken-tb1` | el repo del TB1 de KenKen |
| `/gpp/av2/` | Gerencia de Proyectos en Computación (1ASI0727), segundo avance | `sops-rosewt` | `GPP-course` |

Fuera de los cursos, la portada enlaza (sin proxy) el taller de la rama IEEE UPC en
<https://jev.rosewt.dev>: su aplicación usa rutas absolutas y no se puede montar en una subcarpeta.

Direcciones viejas: `concurrente.rosewt.dev` es un alias de este sitio y redirige (301) a
`/concurrente/`. `kenken.rosewt.dev` y `sops.rosewt.dev` siguen funcionando por su cuenta, porque
esos enlaces pueden haberse entregado a los docentes; uni solo los suma al catálogo.

## Cómo funciona

- `sitio/index.html`: la portada, a mano.
- `sitio/_redirects`: una regla de proxy por curso o entrega (`/curso/* https://<origen>.netlify.app/:splat 200`)
  y las redirecciones de los dominios viejos.
- `netlify/edge-functions/barra.ts`: agrega la barra final a las rutas de carpeta
  (`/concurrente` → `/concurrente/`). Sin ella, los enlaces relativos de las páginas montadas se
  resuelven contra la carpeta de arriba y se rompen (con el deck de KenKen fallaban 88 recursos).
  No se puede hacer en `_redirects`: Netlify compara rutas sin mirar la barra final, así que una
  regla `/x → /x/` entra en bucle.
- `publicar.sh`: sube todo al sitio `uni-rosewt` (cuenta r0sewt). El dominio está en el DNS de
  Netlify, así que el registro y el certificado (`*.rosewt.dev`) son automáticos.

```bash
bash publicar.sh
```

## Sumar una entrega

1. Publicarla desde su repo en un sitio de Netlify propio. Sus enlaces internos tienen que ser
   relativos (`pc3/`, no `/pc3/`): la página se sirve dentro de una subcarpeta.
2. Si el curso es nuevo, agregar su regla en `sitio/_redirects`. Si el curso ya está montado entero
   (como `/concurrente/*`), no hace falta: la entrega aparece sola en `/concurrente/<entrega>/`.
3. Agregar su tarjeta en `sitio/index.html` y correr `bash publicar.sh`.

Después de este ciclo solo quedan los dos cursos de tesis: entran igual, como `/tesis1/` y
`/tesis2/` o con el nombre de su repo.
