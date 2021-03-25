{
  let dd = String(today.getDate()).padStart(2, '0');
  let mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0
  let yyyy = today.getFullYear();
  let today = `${dd}/${mm}/${yyyy}`;
  let message = 'Source: www.utilitr.org, date : ' + today;

  document.documentElement.style.setProperty('--date-header', `'${message}'`);
}
