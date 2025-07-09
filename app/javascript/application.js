// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';

window.changeYear = function(isbn, direction, event) {
  //年移動はcallyによる月移動イベントの伝搬を防ぐ
  if (event) event.stopPropagation();

  const yearDisplay = document.getElementById(`year-display-${isbn}`);
  if (!yearDisplay) return;

  const currentYear = parseInt(yearDisplay.textContent);
  const newYear = currentYear + direction;
  yearDisplay.textContent = newYear + '年';
};
