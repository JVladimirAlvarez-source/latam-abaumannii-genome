# LATAM *Acinetobacter baumannii* Genome Downloader

![Bash Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![NCBI Datasets](https://img.shields.io/badge/NCBI-Datasets-2B16%2B2B-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)

Script automatizado para la descarga masiva de genomas ensamblados de ***Acinetobacter baumannii*** provenientes de proyectos epidemiológicos y genómicos de América Latina. Diseñado para facilitar la construcción de conjuntos de datos en proyectos de genómica comparativa, epidemiología molecular y entrenamiento de modelos predictivos de resistencia a los antimicrobianos (AMR).

---

##  Tabla de Contenidos

- [Características](#-características)
- [Cobertura de Datos](#-cobertura-de-datos)
- [Requisitos Previos](#-requisitos-previos)
- [Instalación y Uso](#-instalación-y-uso)
- [Estructura del Repositorio](#-estructura-del-repositorio)
- [Licencia](#-licencia)

---

##  Características

*  **Descarga Automática:** Interacción directa con las APIs oficiales de NCBI/BV-BRC.
*  **Enfoque Regional:** Filtrado específico para aislamientos geográficos de América Latina, recuperando genomas con perfiles de resistencia a antibióticos.
* 📁 **Organización Estandarizada:** Estructura de carpetas optimizada para análisis bioinformáticos posteriores.

---

## 🌍 Cobertura de Datos

El script está optimizado para recuperar aislados de países de la región, tales como:
* Argentina
* Brasil
* Chile
* Paraguay
* Perú
* Bolivia
---

## Requisitos Previos

Antes de ejecutar el script, asegúrate de contar con los siguientes componentes instalados en tu sistema Unix/Linux:

* `bash` (v4.0 o superior)
* `curl` / `wget`
* `ncbi-datasets-cli` (Herramienta de línea de comandos de NCBI)

---

##  Instalación y Uso

1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/JVladimirAlvarez-source/latam-abaumannii-genome.git](https://github.com/JVladimirAlvarez-source/latam-abaumannii-genome.git)
   cd latam-abaumannii-genome

##  Cobertura de Datos

El script descarga y consolida conjuntos genómicos reportados para los siguientes países de América Latina:

| País | Fuente / Repositorio | Identificador | Cantidad Aprox. |
| :--- | :--- | :--- | :---: |
| 🇦🇷 **Argentina** | NCBI GenBank (WGS) | `NXGW00000000.1`, `PGTR00000000.1`, `NTFR00000000.1` | 3 cepas |
| 🇧🇴 **Bolivia** | ENA | `QXPJ01000000` | 55 cepas |
| 🇧🇷 **Brasil** | NCBI BioProject | [PRJNA613847](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA613847) | 89 cepas |
| 🇵🇾 **Paraguay** | NCBI BioProject | [PRJNA1012735](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1012735) | 43 cepas |
| 🇵🇪 **Perú** | NCBI BioProject | [PRJNA1339005](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1339005) | 19 cepas |
| 🇨🇱 **Chile** | NCBI BioProject | [PRJNA731249](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA731249) | 34 cepas |

---


### Instalación rápida de NCBI Datasets CLI



```bash

\# Descargar binario

curl -o datasets \[https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets](https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets)



\# Otorgar permisos de ejecución

chmod +x datasets



\# Mover al PATH del sistema

sudo mv datasets /usr/local/bin/



```



\---


## Instalación



Clona este repositorio en tu máquina local:



```bash

git clone \[https://github.com/tu-usuario/latam-abaumannii-genomes.git](https://github.com/tu-usuario/latam-abaumannii-genomes.git)

cd latam-abaumannii-genomes



```



Otorga permisos de ejecución al script:



```bash

chmod +x download\_aba\_genomes.sh



```



\---



## Uso



Ejecuta el script directamente desde la terminal:



```bash

./download\_aba\_genomes.sh



```



\---



##  Estructura del Proyecto



Tras completar la descarga, se generará la siguiente estructura de directorios:



```text

latam-abaumannii-genomes/

├── download\_aba\_genomes.sh            # Script ejecutable principal

├── download\_aba\_genomes\_YYYYMMDD.log  # Archivo de log generado

└── genomes/                           # Carpeta contenedora de genomas

&#x20;   ├── argentina/                     # Genomas de Argentina (FASTA)

&#x20;   ├── brazil/                        # Genomas de Brasil (FASTA)

&#x20;   ├── chile/                         # Genomas de Chile (FASTA)

&#x20;   ├── paraguay/                      # Genomas de Paraguay (FASTA)

&#x20;   ├── peru/                          # Genomas de Perú (FASTA)

&#x20;   └── bolivia\_55.fasta.gz            # Archivo WGS comprimido de Bolivia



```



\---



## 📝 Manejo de Registros (Logs)



El script cuenta con un sistema de registro de eventos con códigos de color en la consola que simultáneamente guarda una copia en disco:



\* \*\*`\[INFO]`\*\* Indica progreso normal y estado exitoso.

\* \*\*`\[WARN]`\*\* Advertencias o eventos no críticos.

\* \*\*`\[ERROR]`\*\* Fallos de dependencias o problemas durante la descarga de un BioProject.



\---



##  Licencia



Este proyecto está bajo la Licencia MIT. Consulta el archivo \[LICENSE](https://www.google.com/search?q=LICENSE) para más detalles.

