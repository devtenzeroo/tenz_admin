module.exports = {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  darkMode: 'class', // Enable class-based dark mode
  theme: {
    extend: {
      colors: {
        primary: '#7c3aed',
        accent: '#06b6d4',
      },
      boxShadow: {
        card: '0 10px 30px rgba(2,6,23,0.3)',
      }
    },
  },
  plugins: [],
}
