const { environment } = require('@rails/webpacker');
const webpack = require('webpack');
environment.plugins.append(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquary',
        jQuery: 'jquary',
        Popper: ['popper.js', 'default'],
    })
);

module.exports = environment;
