const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        tuskerGrotesk: ['tusker-grotesk'],
        scto: ['scto-grotesk-a']
      },
    },
    colors: {
      'white': '#FFFFFF',
      'red': "#FF4C4C",
      'dark-red': "#140000",
      'dark': "#1B1B1B",
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
