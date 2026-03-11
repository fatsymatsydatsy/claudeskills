#!/bin/bash

echo ""
echo "Installing Claude skills and agents..."
echo ""

# Create the folders if they don't exist
mkdir -p ~/.claude/skills
mkdir -p ~/.claude/agents

# Copy skills
cp -r skills/new-project ~/.claude/skills/
cp -r skills/execute-phase ~/.claude/skills/

# Copy agents
cp agents/audit-agent.md ~/.claude/agents/
cp agents/execution-agent.md ~/.claude/agents/
cp agents/researcher.md ~/.claude/agents/
cp agents/roadmapper.md ~/.claude/agents/
cp agents/synthesizer.md ~/.claude/agents/
cp agents/test-agent.md ~/.claude/agents/

echo "Done! Skills and agents are installed."
echo ""
echo "Open a project folder in your terminal and type 'claude' to get started."
echo ""
