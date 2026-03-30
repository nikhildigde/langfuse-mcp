.PHONY: check-skills release-skills

# Skill integrity: skills/ is canonical, .claude/skills/ and .agents/skills/ are symlinks
check-skills:
	@echo "Checking skill symlinks..."
	@test -L .claude/skills/langfuse || (echo "❌ .claude/skills/langfuse is not a symlink" && exit 1)
	@test -L .agents/skills/langfuse || (echo "❌ .agents/skills/langfuse is not a symlink" && exit 1)
	@test "$$(readlink .claude/skills/langfuse)" = "../../skills/langfuse" || (echo "❌ .claude/skills/langfuse target is not ../../skills/langfuse" && exit 1)
	@test "$$(readlink .agents/skills/langfuse)" = "../../skills/langfuse" || (echo "❌ .agents/skills/langfuse target is not ../../skills/langfuse" && exit 1)
	@diff -rq skills/langfuse .claude/skills/langfuse || (echo "❌ .claude/skills/langfuse content mismatch" && exit 1)
	@echo "✓ Skill symlinks valid"

release-skills:
	@test -n "$(RELEASE_VERSION)" || (echo "usage: make release-skills RELEASE_VERSION=0.5.4" && exit 1)
	./scripts/release-skills.sh "$(RELEASE_VERSION)"
