# Contributing to Flutter Core Template 🤝

First off, thank you for considering contributing to Flutter Core Template! It's people like you that make this template better for everyone.

## 🌟 Ways to Contribute

### 1. 🐛 Report Bugs
Found a bug? Help us fix it!
- Use the [issue tracker](https://github.com/yourusername/flutter_core/issues)
- Check if the issue already exists
- Provide detailed reproduction steps
- Include Flutter/Dart versions

### 2. 💡 Suggest Features
Have ideas for improvements?
- Open a [discussion](https://github.com/yourusername/flutter_core/discussions)
- Explain the use case
- Describe the expected behavior
- Consider backward compatibility

### 3. 📝 Improve Documentation
Documentation is always welcome!
- Fix typos or unclear explanations
- Add examples and use cases
- Translate to other languages
- Create tutorials or guides

### 4. 🔧 Submit Code
Ready to contribute code?
- Follow the guidelines below
- Keep changes focused
- Add tests if applicable
- Update documentation

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.11+)
- Dart SDK (3.0+)
- Git
- Code editor (VS Code recommended)

### Setup Development Environment

1. **Fork the repository**
   ```bash
   # Click "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/qasimerror404/flutter_core.git
   cd flutter_core
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/qasimabbas/flutter_core.git
   ```

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Generate required files**
   ```bash
   flutter gen-l10n
   flutter pub run build_runner build
   ```

6. **Run the app**
   ```bash
   flutter run
   ```

---

## 📋 Development Workflow

### 1. Create a Branch
```bash
git checkout -b feature/amazing-feature
# or
git checkout -b fix/bug-description
```

Branch naming convention:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation
- `refactor/` - Code refactoring
- `test/` - Adding tests
- `chore/` - Maintenance tasks

### 2. Make Your Changes

Follow these guidelines:

#### Code Style
- Use `dart format` before committing
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Keep lines under 100 characters
- Use meaningful variable names
- Add comments for complex logic

#### Architecture
- Follow Clean Architecture principles
- Maintain separation of concerns
- Use the existing folder structure
- Keep features modular and independent

#### Naming Conventions
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/Functions: `camelCase`
- Constants: `camelCase`
- Providers: `camelCaseProvider`

### 3. Write Tests
```bash
# Add tests in test/ directory
test/
├── unit/           # Unit tests
├── widget/         # Widget tests
└── integration/    # Integration tests

# Run tests
flutter test
```

### 4. Update Documentation
- Update README.md if needed
- Add inline code comments
- Update CHANGELOG.md
- Add examples if applicable

### 5. Commit Your Changes

Use conventional commits:
```bash
git commit -m "feat: add amazing feature"
git commit -m "fix: resolve issue with products"
git commit -m "docs: update setup guide"
git commit -m "refactor: improve error handling"
```

Commit message format:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `style:` - Formatting
- `refactor:` - Code restructuring
- `test:` - Adding tests
- `chore:` - Maintenance

### 6. Push to Your Fork
```bash
git push origin feature/amazing-feature
```

### 7. Submit Pull Request

- Go to the original repository
- Click "New Pull Request"
- Select your branch
- Fill out the PR template
- Link related issues
- Request review

---

## ✅ Pull Request Checklist

Before submitting, ensure:

- [ ] Code follows the style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings generated
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] CHANGELOG.md updated
- [ ] No breaking changes (or documented)
- [ ] Screenshots added (if UI changes)

---

## 🔍 Code Review Process

1. **Automated Checks**
   - Flutter analyze
   - Tests execution
   - Code formatting

2. **Manual Review**
   - Code quality
   - Architecture adherence
   - Documentation completeness

3. **Feedback**
   - Address review comments
   - Push updates to same branch
   - Re-request review

4. **Merge**
   - Approved PRs merged by maintainers
   - Branch deleted after merge

---

## 🎯 What We're Looking For

### High Priority
- 🐛 Bug fixes
- 📚 Documentation improvements
- 🧪 Test coverage
- ♿ Accessibility enhancements
- 🌍 Localization additions

### Medium Priority
- ✨ New features (discuss first)
- ⚡ Performance improvements
- 🎨 UI/UX enhancements
- 🔧 Tool improvements

### Low Priority
- 🧹 Code cleanup
- 📦 Dependency updates
- 🏗️ Refactoring

---

## 💬 Communication

### Ask Questions
- Open a [discussion](https://github.com/yourusername/flutter_core/discussions)
- Comment on related issues
- Join our community chat (if available)

### Report Issues
- Use issue templates
- Provide context and examples
- Be respectful and constructive

### Request Features
- Explain the problem it solves
- Provide use cases
- Consider alternatives

---

## 📜 Code of Conduct

### Our Standards

✅ **Do:**
- Be respectful and inclusive
- Welcome newcomers
- Give constructive feedback
- Focus on the code, not the person
- Acknowledge contributions

❌ **Don't:**
- Use inappropriate language
- Make personal attacks
- Harass others
- Share private information
- Troll or spam

### Enforcement

Violations will result in:
1. Warning
2. Temporary ban
3. Permanent ban

---

## 🏆 Recognition

Contributors are recognized in:
- README.md Contributors section
- CHANGELOG.md
- Release notes
- Special mentions for significant contributions

---

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Riverpod Documentation](https://riverpod.dev)

---

## 🙏 Thank You!

Every contribution, no matter how small, makes a difference. Thank you for being part of making Flutter Core Template better!

---

<div align="center">

**Questions?** Open a [discussion](https://github.com/yourusername/flutter_core/discussions)

**Found a bug?** Create an [issue](https://github.com/yourusername/flutter_core/issues)

**Want to chat?** [Join our community](#)

</div>

