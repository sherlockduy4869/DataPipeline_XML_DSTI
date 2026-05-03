# Data Pipeline 1

---

## Context

This project focuses on designing and implementing an XML-based database platform for a **sports club**. The system integrates and manages diverse entities — such as members, coaches, training sessions, facilities, teams, competitions, equipment, memberships, and bookings — to ensure efficient coordination and streamlined access to information. The project covers:

- data modeling and management: Structuring and maintaining information about all entities and their relationships, including membership records, team organization, scheduling, and facility usage.
- user-oriented functionalities exploiting the database and supporting various user needs, such as searching for training sessions or teams, booking facilities or classes, managing memberships and renewals, etc.

The platform showcases effective exploitation of XML technologies for real-world sports club operation and resource management.

## Evaluation

The project will be evaluated according to the **quality and richness of modeling** (modular schema, fine grained type definitions and constraints), the **quality and richness of the addressed scenarios/use cases/functionalities**, the **quality of the stylesheets** (prefer a recursive XSL programming style that extensively uses XPath), the quality of Python (and optional Java) codes, and the quality of the report showing the **ability to take a step back**.

---

## Project's Structure

```
DATA_PIPELINE_FINAL_PROJECT/
|______ sport_club.xml         (XML database — representative extract)
|______ sport_club.xsd         (XML Schema — modeling and constraints)
|______ scenarios/             (10 XSLT stylesheets)
|         |______ scenario_1.xsl  ...  scenario_10.xsl
|______ results/               (transformation outputs)
|         |______ scenario_1.html ... scenario_6.html  (HTML)
|         |______ scenario_7.html  scenario_8.html     (XML output)
|         |______ scenario_9.html  scenario_10.json    (JSON output)
|______ Final.py               (Python pipeline: validate + transform)
|______ scenarios_documents.md (scenario goals)
|______ A25-Project.pdf        (project brief)
```

---

## XSLT Set up Instructions

The Python pipeline (`Final.py`) drives all transformations using `lxml`. As an alternative, individual XSLT files can be run from the command line with `xsltproc` (preinstalled on macOS/Linux):

```shell
xsltproc scenarios/scenario_1.xsl sport_club.xml > results/scenario_1.html
```

On Mac/Linux, `xsltproc` is available out of the box.
On Windows, install `libxslt` or use the Python pipeline below.

---

## Running XSLT Transformations

Each scenario reads `sport_club.xml`, validates it against `sport_club.xsd`, then applies the corresponding XSLT stylesheet from `scenarios/`.

The output extension is determined automatically by `Final.py`:

| Scenario range | Output format | Folder       |
|----------------|---------------|--------------|
| 1 – 6          | HTML          | `results/`   |
| 7 – 8          | XML           | `results/`   |
| 9 – 10         | JSON          | `results/`   |

---

### Scenario 1: Team size comparison (HTML)

Counts the number of members per team and renders a comparison table.

```shell
python Final.py
# Enter scenario number (1–10): 1
```

Output: `results/scenario_1.html`

---

### Scenario 2: Membership distribution (HTML)

Aggregates members by membership level (GOLD / SILVER / BRONZE) and shows totals.

```shell
python Final.py
# Enter scenario number (1–10): 2
```

Output: `results/scenario_2.html`

---

### Scenario 3: Teams and their coaches (HTML)

Joins each team with its coach via `MES/@idref` and lists the coach's specialty.

```shell
python Final.py
# Enter scenario number (1–10): 3
```

Output: `results/scenario_3.html`

---

### Scenario 4: Full training schedule (HTML)

Displays a training schedule combining session date/time, team name, facility, location, and equipment.

```shell
python Final.py
# Enter scenario number (1–10): 4
```

Output: `results/scenario_4.html`

---

### Scenario 5: Upcoming competition calendar (HTML)

Lists competitions ordered by date with the participating team resolved through `TEAMID`.

```shell
python Final.py
# Enter scenario number (1–10): 5
```

Output: `results/scenario_5.html`

---

### Scenario 6: Facility usage report (HTML)

Reports each facility's information together with the training sessions it hosts.

```shell
python Final.py
# Enter scenario number (1–10): 6
```

Output: `results/scenario_6.html`

---

### Scenario 7: Simplified public directory (XML)

Restructures teams and members into a flatter `publicDirectory` XML format suitable for external consumption.

```shell
python Final.py
# Enter scenario number (1–10): 7
```

Output: `results/scenario_7.html` (XML payload)

---

### Scenario 8: Teams hierarchy (XML)

Reorganizes the database around teams, embedding their roster (members) and coach reference into a `teamsHierarchy` document.

```shell
python Final.py
# Enter scenario number (1–10): 8
```

Output: `results/scenario_8.html` (XML payload)

---

### Scenario 9: Team summaries with computed data (JSON)

Emits a JSON `teamsSummary` array with `teamId`, `teamName`, `coachId`, and the computed `totalMembers`.

```shell
python Final.py
# Enter scenario number (1–10): 9
```

Output: `results/scenario_9.html` (JSON payload)

---

### Scenario 10: Training sessions export (JSON)

Exports training sessions to JSON, resolving each session's team name and facility name through cross-entity XPath lookups.

```shell
python Final.py
# Enter scenario number (1–10): 10
```

Output: `results/scenario_10.json`

---

## Python Set up Instructions

**Python version used:**
- Python 3.10+

Install the single dependency:

```shell
pip install lxml
```

### Configuration

`Final.py` defines a `BASE_DIR` constant at the top of the file. Update it to match your local project path before running:

```python
BASE_DIR = r"/absolute/path/to/XML"
```

### Running the Python Pipeline

From the project root, launch the CLI program that validates `sport_club.xml` against `sport_club.xsd` and applies the selected XSLT stylesheet:

```shell
python Final.py
```

The program prompts:

```
Enter scenario number (1–10):
```

Enter a number between 1 and 10. The corresponding stylesheet from `scenarios/` is applied and the result is written to `results/` with the format determined by the scenario range (HTML / XML / JSON).

---

## Deliverables (per project brief)

The project produces the artifacts required by the assignment:

- XML Schema (`sport_club.xsd`) modeling members, coaches, teams, training sessions, facilities, competitions, equipment, memberships, and bookings, with `xs:key` / `xs:keyref` integrity constraints.
- XML database (`sport_club.xml`) valid against the schema.
- 10 XSLT stylesheets in `scenarios/`:
  - 6 visualizations producing HTML
  - 2 transformations producing alternative XML formats
  - 2 transformations producing JSON
- Python pipeline (`Final.py`) that loads, parses, validates, and transforms XML using `lxml`.
- All XSL files include comments describing their purpose in natural language.
