module.exports = function(api) {
  var validEnvironment = ['development', 'test', 'production']
  var currentEnvironment = api.env()
  var isDevelopmentEnvironment = api.env('development')
  var isProductionEnvironment = api.env('production')
  var isTestEnvironment = api.env('test')

  if (!validEnvironment.includes(currentEnvironment)) {
    throw new Error(
      'Please specify a valid `NODE_ENV` or ' +
        '`BABEL_ENV` environment variables. Valid values are "development", ' +
        '"test", and "production". Instead, received: ' +
        JSON.stringify(currentEnvironment) +
        '.'
    )
  }

  return {
    presets: [
      isTestEnvironment && [
        '@babel/preset-env',
        {
          targets: {
            node: 'current'
          }
        }
      ],
      (isProductionEnvironment || isDevelopmentEnvironment) && [
        '@babel/preset-env',
        {
          forceAllTransforms: true,
          useBuiltIns: 'entry',
          corejs: 3,
          modules: false,
          exclude: ['transform-typeof-symbol']
        }
      ]
    ].filter(Boolean),
    plugins: [
      'babel-plugin-macros',
      '@babel/plugin-syntax-dynamic-import',
      isTestEnvironment && 'babel-plugin-dynamic-import-node',
      '@babel/plugin-transform-destructuring',
      [
        '@babel/plugin-proposal-class-properties',
        {
          loose: true
        }
      ],
      [
        '@babel/plugin-proposal-object-rest-spread',
        {
          useBuiltIns: true
        }
      ],
      [
        '@babel/plugin-proposal-private-methods',
        {
          loose: true
        }
      ],
      [
        '@babel/plugin-proposal-private-property-in-object',
        {
          loose: true
        }
      ],
      [
        '@babel/plugin-transform-runtime',
        {
          helpers: false
        }
      ],
      [
        '@babel/plugin-transform-regenerator',
        {
          async: false
        }
      ]
    ].filter(Boolean)
  }
}
