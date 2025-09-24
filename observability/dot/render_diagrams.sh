#!/bin/bash

# Script to render DOT diagrams from dot/ directory to figures/ directory
# for inclusion in LaTeX documents

# Set directories (relative to dot/ directory)
DOT_DIR="."
FIGURES_DIR="../figures"

# Create figures directory if it doesn't exist
mkdir -p "$FIGURES_DIR"

echo "Rendering DOT diagrams..."

# Render architecture.dot to PDF
if [ -f "$DOT_DIR/architecture.dot" ]; then
    echo "  Rendering architecture.dot -> architecture.pdf"
    dot -Tpdf -Gsize="8,6!" -Gdpi=300 "$DOT_DIR/architecture.dot" -o "$FIGURES_DIR/architecture.pdf"
    
    # Also create PNG version for backup/web use
    echo "  Rendering architecture.dot -> architecture.png"
    dot -Tpng -Gsize="8,6!" -Gdpi=300 "$DOT_DIR/architecture.dot" -o "$FIGURES_DIR/architecture.png"
else
    echo "  Warning: $DOT_DIR/architecture.dot not found"
fi

# Add any other DOT files here in the future
# Example:
# if [ -f "$DOT_DIR/other_diagram.dot" ]; then
#     echo "  Rendering other_diagram.dot -> other_diagram.pdf"
#     dot -Tpdf -Gsize="8,6!" -Gdpi=300 "$DOT_DIR/other_diagram.dot" -o "$FIGURES_DIR/other_diagram.pdf"
# fi

echo "Done rendering diagrams!"
echo "Generated files in $FIGURES_DIR/:"
ls -la "$FIGURES_DIR/"