// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';

window.changeYear = function (isbn, direction, event) {
  //年移動はcallyによる月移動イベントの伝搬を防ぐ
  if (event) event.stopPropagation();

  const yearDisplay = document.getElementById(`year-display-${isbn}`);
  if (!yearDisplay) return;

  const currentYear = parseInt(yearDisplay.textContent);
  const newYear = currentYear + direction;
  yearDisplay.textContent = newYear + '年';

  const calendarDate = document.querySelector(
    `#year-calendar-popover${isbn} calendar-date`
  );
  if (calendarDate) {
    let currentMonth = calendarDate.value
      ? new Date(calendarDate.value).getMonth()
      : new Date().getMonth();

    const newDate = new Date(newYear, currentMonth, 1);
    // callyのAPIがあればsetDate、なければvalue属性を直接変更
    if (typeof calendarDate.setDate === 'function') {
      calendarDate.setDate(newDate);
    } else {
      const y = newDate.getFullYear();
      const m = String(newDate.getMonth() + 1).padStart(2, '0');
      calendarDate.value = `${y}-${m}-01`;
      calendarDate.setAttribute('value', `${y}-${m}-01`);
    }
  }
};
