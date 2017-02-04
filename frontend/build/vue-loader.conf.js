const utils = require('./utils');
const config = require('../config');
const isProduction = process.env.NODE_ENV === 'production';

module.exports = {
  loaders: utils.cssLoaders({
    sourceMap: isProduction
      ? config.build.productionSourceMap
      : config.dev.cssSourceMap,
    extract: isProduction,
  }),
  postcss: [
    require('postcss-import'),
    require('autoprefixer')({
      browsers: ['last 2 versions'],
    }),
    require('postcss-cssnext'),
  ],
};
