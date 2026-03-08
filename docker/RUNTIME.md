# Runtime Capabilities

Base image: `python:3.11-slim-bookworm`

## Preinstalled system tools
- bash
- build-essential
- curl
- file
- git
- jq
- poppler-utils
- ripgrep
- sqlite3
- tree
- unzip
- xz-utils
- zip
- ca-certificates
- libmagic1

## Preinstalled Python packages
### Core engineering
- requests
- httpx
- aiohttp
- pytest
- pytest-asyncio
- black
- flake8
- mypy
- pydantic
- pyyaml
- tabulate

### Data and tabular processing
- numpy
- pandas
- openpyxl
- xlrd
- pyxlsb
- odfpy

### HTML and text extraction
- beautifulsoup4
- lxml
- html5lib
- markdownify
- chardet

### Documents and PDF
- pypdf
- pdfplumber
- reportlab
- python-docx
- python-pptx
- pillow

## What this runtime is good at
- general coding and test execution;
- HTML parsing and scraping of provided content;
- CSV, Excel, and ODF-style spreadsheet processing;
- PDF text extraction and PDF generation;
- Word and PowerPoint document inspection/generation;
- small-to-medium data-analysis and reporting tasks.

## Notes
- This image is intentionally richer than a minimal coding image so the agent can handle common document and data tasks without immediate rebuilds.
- It is still not a universal build farm; language-specific ecosystems can be added in downstream images.
- If you add more heavy runtimes, keep the default JSON contract and sandbox behavior unchanged.
