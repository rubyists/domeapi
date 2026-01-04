# Coding Standards for Agents

---
This file describes the desired coding standards and for the domeapi ruby project.

## Project Context

**Language:** Ruby ~> 4
**Framework:** [trailblazer](https://trailblazer.to/)
**Testing:** [minitest](https://docs.seattlerb.org/minitest/) following [BetterSpecs](https://evenbetterspecs.github.io/) guidelines

---

## Purpose & Scope

Focused guidance for Ruby style, tests, performance, and tone.

---

## 1. Style Guides

> ⚠️ **Be constructive:** Frame style feedback as suggestions (e.g., “Consider using…”).

All standard rules follow the [Shopify Ruby Style Guide](https://ruby-style-guide.shopify.dev/), with the following specific emphases:
- Indentation and line length enforced by RuboCop.
- Use guard clauses, and explicit receivers.
- Prefer Railway Oriented Programming (ROP) for error handling and flow. The trailblazer framework encourages this style.
- Keep methods short. 1 line is fine. 5 is a lot. At 7, you should consider extracting a method.

---

## 2. Tone and Delivery (For code reviews)

> 🤝 **Be collaborative:** Lead with positives and offer improvements respectfully.

- Open with a brief positive comment on well‑written code.
- Use phrasing like “Consider extracting…” or “You might simplify…” rather than absolutes.
- Keep comments concise—2–3 sentences max.
- Focus on actionable suggestions.
- Avoid overwhelming with too many minor issues; prioritize key improvements.

---

## 3. Conventions & Readability

> ✨ **Keep it clear:** Propose naming and structure that clarify intent.

- **SOLID principles:** Single responsibility; inject dependencies via initializers.
- **Descriptive names:** Recommend clear class, method, and variable names.
- **DRY:** Suggest extracting duplicate logic into modules or service objects.
    - Encourage use of Trailblazer operations for business logic encapsulation.     
    - Promote use of Cells for view components to enhance reusability and maintainability.
    - Encourage use of Contracts for validation to keep models clean and focused.
    - Utilize Dry Container for dependency management to improve testability and modularity.
- **Method size:** Keep them short, in reviews suggest extractions when exceeding ~7 lines.
- Structs are our friend for grouping related data without behavior.
- Favor composition over inheritance; prefer modules and mixins.
- Ensure files have EOF newline.
- No trailing white space in code and comments.

---

## 4. Testing and Coverage

> 🧪 **Be thorough:** Highlight gaps in meaningful test coverage.

- Flag or fix missing or outdated specs for changed behaviors (unit, integration, request).
- Suggest tests for edge cases: error conditions, invalid inputs, boundary values, and potential `nil` handling or pointer exceptions. Follow best practices from the [BetterSpecs style guide](https://evenbetterspecs.github.io/).
- Encourage descriptive `context` blocks and example names per [BetterSpecs](https://evenbetterspecs.github.io/).
- Flag missing specs when logic is updated but no tests were added or modified
- No less than 100% branch coverage. Full stop.
---

## 5. Performance and Security

> 🚀 **Guard quality:** Call out patterns that may hurt performance or security.

- Detect potential N+1 queries; suggest `includes` or batching.
- Attempt to identify O(n^2) or O(n log n) algorithms; recommend more efficient alternatives.
- Flag raw SQL, unsanitized interpolation, or other patterns that could introduce potential SQL injection vulnerabilities; recommend parameter binding and Sequel-based alternatives. Build these into a model, avoid raw SQL unless absolutely necessary.
- Identify unescaped user input in any i/o context (cli, api, file writes, logs); suggest proper escaping or sanitization.

---

## 6. Documentation and Comments

> 📚 **Clarify intent:** Advocate for clear, concise documentation.

- All methods should have yarddoc annotations in the format:
  ```ruby
  # Short description of the method.
  #
  # @param [Type] param_name Description of the parameter.
  #
  # @return [Type] Description of the return value.
  ```
- Explain the "why" behind code choices, not the "what."
- Add comments only for complex logic or non-obvious decisions.
- Comments become tech-debt if they are not maintained; use them judiciously.
