#!/usr/bin/env node

// Syncs the version from package.json into the CoffeeScript source file's
// @preserve comment block. Runs automatically via the "version" npm hook.

const fs = require('fs');
const path = require('path');

// ---- Adjust this path to your actual CoffeeScript source file ----
const COFFEE_FILE = path.join(__dirname, '..', 'jquery.pretty-text-diff.coffee');

// Matches: @preserve jQuery.PrettyTextDiff 1.0.4
const VERSION_PATTERN = /(@preserve\s+jQuery\.PrettyTextDiff\s+)(\d+\.\d+\.\d+)/;

function bumpCoffeeVersion() {
    const pkg = require(path.join(__dirname, '..', 'package.json'));
    const newVersion = pkg.version;

    let content = fs.readFileSync(COFFEE_FILE, 'utf8');

    if (!VERSION_PATTERN.test(content)) {
        console.error(`Could not find "@preserve jQuery.PrettyTextDiff x.y.z" in ${COFFEE_FILE}`);
        process.exit(1);
    }

    content = content.replace(VERSION_PATTERN, `$1${newVersion}`);

    fs.writeFileSync(COFFEE_FILE, content, 'utf8');

    console.log(`Updated version in ${COFFEE_FILE} to ${newVersion}`);
}

bumpCoffeeVersion();
