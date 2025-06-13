// eslint.config.mjs

// @ts-check
import { globalIgnores } from 'eslint/config';
import eslint from '@eslint/js';
import globals from 'globals';
import tseslint from 'typescript-eslint';
import eslintConfigPrettier from 'eslint-config-prettier/flat';
import prettierPlugin from 'eslint-plugin-prettier';

export default tseslint.config([
  eslint.configs.recommended,
  tseslint.configs.recommended,
  globalIgnores(['package-lock.json', 'dist/', 'node_modules/']),
  {
    files: ['**/*.{js,mjs,cjs,ts,mts,cts}'],
    languageOptions: {
      globals: { ...globals.browser, ...globals.node, ...globals.jest },
    },
  },
  {
    files: ['**/*.{js,mjs,cjs,ts,mts,cts}'],
    languageOptions: {
      parser: tseslint.parser,
      parserOptions: {
        project: ['./tsconfig.json'],
      },
    },
    plugins: { '@typescript-eslint': tseslint.plugin },
    rules: {},
  },
  eslintConfigPrettier,
  {
    plugins: { prettier: prettierPlugin },
    rules: {
      'prettier/prettier': 'error',
    },
  },
  {
    rules: {
      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-floating-promises': 'warn',
      '@typescript-eslint/no-unsafe-argument': 'warn',
    },
  },
]);
