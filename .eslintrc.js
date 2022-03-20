module.exports = {
  parserOptions: {
    ecmaVersion: 6,
  },
  env: {
    es6: true,
    node: true,
  },
  root: true,
  extends: ["eslint:recommended"],
  overrides: [
    {
      files: ["*.mjs?(x)"],
      extends: ["plugin:prettier/recommended"],
      parserOptions: {
        sourceType: "module",
      },
    },
    {
      files: ["*.ts?(x)"],
      extends: [
        "plugin:@typescript-eslint/recommended",
        "plugin:prettier/recommended",
      ],
      parserOptions: {
        ecmaVersion: 8,
        project: "./tsconfig.json",
      },
      rules: {
        "@typescript-eslint/explicit-function-return-type": [
          "warn",
          {
            allowExpressions: true,
            allowTypedFunctionExpressions: true,
          },
        ],
        "@typescript-eslint/explicit-member-accessibility": [
          "error",
          { accessibility: "no-public" },
        ],
        "@typescript-eslint/no-unused-vars": [
          "warn",
          { argsIgnorePattern: "^_" },
        ],
      },
    },
  ],
}
