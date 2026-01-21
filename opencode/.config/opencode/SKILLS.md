# OpenCode Skills Sources

This document tracks the sources of skills installed in OpenCode for easy upgrades and maintenance.

## Installation Command

Skills are installed using the `bunx add-skill` command:

```bash
bunx add-skill <repository-path>
```

## Installed Skills

### Core Skills Collection
**Source:** `anthropics/skills`  
**Installation:**
```bash
bunx add-skill anthropics/skills
```
**Description:** Official Anthropic skills collection

**Skills Included:**
- `context7` - Retrieve up-to-date documentation for software libraries
- `skill-creator` - Guide for creating effective skills
- `web-design-guidelines` - UI code review for Web Interface Guidelines compliance
- `vercel-react-best-practices` - React and Next.js performance optimization guidelines
- `test-driven-development` - TDD implementation guidance
- `mcp-builder` - Guide for creating MCP servers
- `frontend-design` - Create production-grade frontend interfaces
- `brainstorming` - Explore user intent and requirements before implementation

### Agent Browser
**Source:** `vercel-labs/agent-browser`  
**Installation:**
```bash
bunx add-skill vercel-labs/agent-browser
```
**Description:** Automates browser interactions for web testing, form filling, screenshots, and data extraction

### Additional Vercel Agent Skills
**Source:** `vercel-labs/agent-skills`  
**Installation:**
```bash
bunx add-skill vercel-labs/agent-skills
```
**Description:** Additional agent skills from Vercel Labs

## Upgrade Instructions

To upgrade all skills to their latest versions:

1. Navigate to the OpenCode config directory:
   ```bash
   cd ~/.config/opencode
   ```

2. Remove existing skills:
   ```bash
   rm -rf skills/
   ```

3. Reinstall skills from their sources:
   ```bash
   bunx add-skill anthropics/skills
   bunx add-skill vercel-labs/agent-browser
   bunx add-skill vercel-labs/agent-skills
   ```

## Directory Structure

Skills are installed to:
- **Symlink location:** `~/.config/opencode/skills/`
- **Dotfiles location:** `~/dotfiles/opencode/.config/opencode/skills/`

The skills directory is symlinked via GNU Stow from the dotfiles repository.

## Notes

- Each skill directory contains its own README and implementation files
- Skills are loaded automatically by OpenCode when placed in the skills directory
- Custom modifications should be documented separately to avoid loss during upgrades
- Check the source repositories for changelogs before upgrading

## Last Updated

2026-01-21
