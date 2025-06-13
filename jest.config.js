// jest.config.js

module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  moduleFileExtensions: ['ts', 'js', 'json'],
  moduleNameMapper: {
    '^~/(.*)$': '<rootDir>/$1',
  },
  // If you use a different tsconfig for tests, point to it:
  globals: {
    'ts-jest': { tsconfig: 'tsconfig.json' },
  },
};
