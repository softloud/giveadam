"""
Simple DBT JSON extraction - no fancy processing.
"""

import json
import pandas as pd

# Load JSON files
with open('../../dbt_project/target/manifest.json', 'r') as f:
    manifest = json.load(f)

with open('../../dbt_project/target/run_results.json', 'r') as f:
    run_results = json.load(f)

# Extract models: node & description
models = []
for node_id, node_data in manifest.get('nodes', {}).items():
    if node_id.startswith('model.'):
        models.append({
            'node': node_id,
            'description': node_data.get('description', '')
        })

# Extract tests: test node & result
tests = []
for result in run_results.get('results', []):
    if result.get('unique_id', '').startswith('test.'):
        tests.append({
            'test_node': result.get('unique_id', ''),
            'result': result.get('status', '')
        })

# Convert to DataFrames and save
models_df = pd.DataFrame(models)
tests_df = pd.DataFrame(tests)

print("=== Models ===")
print(models_df.to_string(index=False))

print("\n=== Tests ===")
print(tests_df.to_string(index=False))

# Save to CSV
models_df.to_csv('models.csv', index=False)
tests_df.to_csv('tests.csv', index=False)
print(f"\nSaved to models.csv and tests.csv")
