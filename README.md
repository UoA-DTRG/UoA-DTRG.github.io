# DTRG Documentation Wiki
[![Deploy Jekyll site to Pages](https://github.com/UoA-DTRG/UoA-DTRG.github.io/actions/workflows/pages.yml/badge.svg)](https://github.com/UoA-DTRG/UoA-DTRG.github.io/actions/workflows/pages.yml)
This is the official documentation wiki for the **Drone Technology Research Group (DTRG)** at the University of Auckland, New Zealand.

## About

The DTRG Documentation Wiki provides comprehensive guides and resources for:
- PX4 autopilot system configuration and development
- Simulation environments and tools
- UAV hardware platforms and assembly
- Flight testing procedures and safety guidelines
- Research methodologies and best practices

Visit our main website: [dtrg.org](https://dtrg.org/)

## Built With

This site is built using:
- [Jekyll](https://jekyllrb.com) - Static site generator
- [Just the Docs](https://just-the-docs.github.io/just-the-docs/) - Documentation theme
- [GitHub Pages](https://pages.github.com/) - Hosting


## Contributing

This wiki is maintained collaboratively by DTRG members. To contribute:

1. Clone the repository and create a feature branch:
  ```bash
  git clone https://github.com/UoA-DTRG/UoA-DTRG.github.io.git
  cd UoA-DTRG.github.io
  git checkout -b feature/your-feature
  make setup # if you haven't already
  make serve # to preview locally
  ```
2. Make your changes following our documentation guidelines
3. Commit your changes (`git commit -m 'Add documentation for X'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

Alternatively, you can edit files directly on GitHub using the web interface and create a Pull Request from there.

### Documentation Guidelines

- Use clear, concise language
- Include relevant images and diagrams where helpful
- Follow the existing file structure and naming conventions
- Keep information up-to-date and accurate
- Test all code examples and procedures before documenting

## Project Structure

```
.
├── _config.yml           # Site configuration
├── index.md             # Home page
├── sections/            # Documentation sections
│   ├── PX4/            # PX4 autopilot guides
│   ├── UAVs/           # UAV hardware documentation
│   ├── guides/         # General guides
│   └── ...
├── assets/             # Images, CSS, and other assets
├── _includes/          # Custom HTML includes
├── _sass/              # Custom styles and color schemes
└── Tools/              # Development helper scripts
```

## Customization

This site uses a custom color scheme based on DTRG brand colors:
- Primary color: `#4b6874` (bluey-green from DTRG logo)
- Background: `#f5f7f9` (custom grey)

Custom styling is located in:
- `_sass/color_schemes/uoa.scss` - Color scheme variables
- `_sass/custom/custom.scss` - Custom CSS overrides
- `_sass/custom/setup.scss` - Callout color definitions

## Contact

- **Website**: [dtrg.org](https://dtrg.org/)
- **Contact Information**: Available on our [main site](https://dtrg.org/index.php/sample-page/contact/)
- **Team Directory**: [Current Team Members](https://dtrg.org/team/current-team/)

## License

This documentation is maintained by the Drone Technology Research Group at the University of Auckland.

