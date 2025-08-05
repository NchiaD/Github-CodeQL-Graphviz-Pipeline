# 📊 Github-CodeQL-Graphviz-Pipeline
Analyze and visualize code relationships by combining GitHub CodeQL queries with Graphviz for clear, dependency-focused graphs.

---

# 🧩 What CodeQL Does

CodeQL is a code analysis engine developed by GitHub that lets you query your code like a database to find bugs, vulnerabilities, or patterns.

| Feature             | Description                                                            |
| ------------------- | ---------------------------------------------------------------------- |
| **Code Analysis**   | Scans code for security issues and bad patterns.                       |
| **Query Language**  | Uses a SQL-like language (QL) to search code structure.                |
| **Custom Queries**  | You can write your own queries to find specific issues.                |
| **Automated Scans** | Works in CI/CD pipelines to automatically scan code.                   |
| **Cross-Language**  | Supports languages like Java, JavaScript, Python, C/C++, C#, and more. |



## 🚀 Quick Start

### ✅ System Prerequisites for CodeQL

| Requirement         | Details                                                             |
| ------------------- | ------------------------------------------------------------------- |
| **OS**              | Windows, macOS, or Linux                                            |
| **CPU & RAM**       | At least 4 cores, 8 GB RAM (more is better for large codebases)     |
| **Disk Space**      | \~1–5 GB per CodeQL database                                        |
| **Internet Access** | Required to download CodeQL packs, updates, dependencies (optional) |

### ✅ Toolchain Prerequisites

| Tool           | Version                  | Notes / Links                                                                                  |
| -------------- | ------------------------ | ---------------------------------------------------------------------------------------------- |
| **CodeQL CLI** | Latest                   | Download: [GitHub CodeQL CLI Releases](https://github.com/github/codeql-cli-binaries/releases) |
| **Java JDK**   | 8 or higher              | Required for analyzing Java projects                                                           |
| **Python**     | 3.7+                     | Required for some scripts / Python code analysis                                               |
| **Node.js**    | 16+                      | Required for analyzing JavaScript/TypeScript projects                                          |
| **.NET SDK**   | .NET Core 3.1+ / .NET 5+ | Required for C# analysis (if applicable)                                                       |
| **Git**        | Any                      | To clone and manage source code repositories                                                   |
| **Graphviz**   | Any                      | Only needed for graph visualizations (e.g., dependency mapping)                                |

---

Got it! You're asking for a **similar prerequisites + setup guide**, but this time for **CodeQL** (especially for dependency mapping or pipeline setup like with Graphviz).

Here's a full breakdown, styled like the one you showed from Depends Visualizer:

---

# ✅ CodeQL + Graphviz Pipeline — Setup Guide

## 📦 Prerequisites

### 🔧 **System Requirements**

| Requirement    | For                          | Notes                           |
| -------------- | ---------------------------- | ------------------------------- |
| **OS**         | Linux, macOS, or Windows     | Cross-platform support          |
| **RAM & CPU**  | ≥ 8GB RAM, ≥ 4 cores         | Larger projects need more       |
| **Disk Space** | 2–10 GB per CodeQL database  | Especially large for Java/JS    |
| **Internet**   | For downloading CodeQL packs | Optional if using offline packs |

---

## 📚 Required Tools

| Tool                               | Version    | Purpose                                  | Install Link                                                                            |
| ---------------------------------- | ---------- | ---------------------------------------- | --------------------------------------------------------------------------------------- |
| **CodeQL CLI**                     | Latest     | Running analysis and queries             | [Download](https://github.com/github/codeql-cli-binaries/releases)                      |
| **Graphviz**                       | Any        | Generating `.dot`, `.svg`, `.png` graphs | [graphviz.org](https://graphviz.org/download/)                                          |
| **Java (JDK)**                     | 8+         | Required for analyzing Java projects     | [OpenJDK](https://openjdk.org)                                                          |
| **Python**                         | 3.7+       | For scripting or integration pipelines   | [python.org](https://www.python.org)                                                    |
| **Node.js**                        | 16+        | Required for JS/TS analysis              | [nodejs.org](https://nodejs.org)                                                        |
| **.NET SDK**                       | .NET 5+    | Required for C# projects                 | [dotnet.microsoft.com](https://dotnet.microsoft.com)                                    |
| **VS Code** + **CodeQL Extension** | (Optional) | Writing and debugging queries            | [Marketplace](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-codeql) |

---

## 🏗️ Setup Steps

### 1. **Install CodeQL CLI**

Download the CLI and unzip it into your tools folder.

```bash
wget https://github.com/github/codeql-cli-binaries/releases/latest/download/codeql-win64.zip
unzip codeql-win64.zip
export PATH=$PATH:/path/to/codeql
```

### 2. **Create a CodeQL Database**

From project source root:

For Java: 

```powershell
.\codeql\codeql.exe database create codeql\db\java-db --language=java --source-root=src\example\Java
```

Other examples:

```powershell
.\codeql\codeql.exe database create codeql\db\python-db --language=python --source-root=src\example\python
```

### 3. **Run an Analysis**

```bash
codeql database analyze my-db \
  codeql-repo/java/ql/src/Security/CWE/CWE-079/*.ql \
  --format=sarifv2.1.0 --output=results.sarif
```

You can also run custom queries or packs:

```bash
codeql database analyze codeql-db \
  ./queries/dependencies.ql \
  --format=csv \
  --output=results/deps.csv
```

---

## 📈 Dependency Graph Output (Graphviz)

If you're using CodeQL + custom Graphviz script or pack:

### 4. **Install or Use Graphviz Formatter**

* Use a custom CodeQL query that outputs `.dot`
* Use Graphviz CLI to convert it:

```bash
dot -Tsvg results/deps.dot -o results/deps.svg
dot -Tpng results/deps.dot -o results/deps.png
```

> You can build your own `*.ql` that outputs dependency edges in DOT format, or use a post-analysis script to convert SARIF to DOT.

---

## 🧪 Example Workflow (Java)

```bash
# 1. Create DB
codeql database create codeql-db --language=java --source-root=./src

# 2. Analyze
codeql database analyze codeql-db queries/dependencies.ql --format=csv --output=results/deps.csv

# 3. Convert to DOT
python3 scripts/csv_to_dot.py results/deps.csv results/deps.dot

# 4. Generate SVG
dot -Tsvg results/deps.dot -o results/deps.svg
```

---

## 📁 Suggested Folder Structure

```
my-project/
├── codeql/
│   ├── db/                        # CodeQL databases (1 per language/project)
│   │   └── java-db/
│   ├── queries/                   # Custom CodeQL queries
│   │   ├── dependencies/
│   │   │   └── DependencyGraph.ql
│   │   └── security/
│   │       └── SQLInjectionCheck.ql
│   ├── results/                   # Output files (CSV, SARIF, etc.)
│   │   ├── deps.csv
│   │   └── analysis-results.sarif
│   └── scripts/                   # Python/postprocessing scripts
│       ├── convert_csv_to_dot.py
│       └── visualize_dot.py
├── graphviz/                      # DOT & image visualizations
│   ├── deps.dot
│   ├── deps.svg
│   └── deps.png
├── src/                           # Your source code
│   └── (project source files)
├── .codeqlconfig.yml              # Optional config file for packs/rules
└── README.md
```

---

## 🧹 Troubleshooting

| Problem                     | Fix                                                    |
| --------------------------- | ------------------------------------------------------ |
| `codeql: command not found` | Ensure CodeQL CLI is on PATH                           |
| `Graphviz: dot not found`   | Install Graphviz and add to PATH                       |
| `.dot` file is empty        | Check if your custom query produces output             |
| Database too large / slow   | Add `--max-disk-usage`, filter files, or split modules |

---

## 📜 License

⚠️ CodeQL → Only free for open-source projects.

❌ CodeQL on private/commercial code → Needs GitHub Advanced Security (GHAS) license.