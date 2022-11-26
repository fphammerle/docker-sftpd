# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- `sshd`: no longer accept RSA keys < 2048 bits for authentication

## [0.1.0] - 2021-03-20
### Added
- openssh server listening on tcp port `2200`
- only sftp access enabled, chrooted to `/data`
- single user `nonroot`
- `authorized_keys` configured via `SSH_CLIENT_PUBLIC_KEYS` env var

[Unreleased]: https://github.com/fphammerle/docker-sftpd/compare/v0.1.0...master
[0.1.0]: https://github.com/fphammerle/docker-sftpd/tree/v0.1.0
