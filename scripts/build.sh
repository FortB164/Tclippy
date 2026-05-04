#!/bin/bash
set -e

echo "🧹 Cleaning old metadata..."
rm -rf dists

echo "📁 Creating repo structure..."
mkdir -p dists/stable/main/binary-amd64

echo "📦 Generating Packages..."

dpkg-scanpackages pool /dev/null \
> dists/stable/main/binary-amd64/Packages

gzip -k -f dists/stable/main/binary-amd64/Packages

echo "📄 Generating Release..."

apt-ftparchive \
  -o APT::FTPArchive::Release::Suite="stable" \
  -o APT::FTPArchive::Release::Codename="stable" \
  -o APT::FTPArchive::Release::Architectures="amd64" \
  -o APT::FTPArchive::Release::Components="main" \
  release dists/stable \
> dists/stable/Release

echo "✅ Repository metadata generated successfully."
