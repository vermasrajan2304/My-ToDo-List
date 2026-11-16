const form = document.getElementById("task-form");
const input = document.getElementById("task-input");
const list = document.getElementById("task-list");
const emptyMessage = document.getElementById("empty-message");
const clearButton = document.getElementById("clear-button");

function updateEmptyMessage() {
  emptyMessage.hidden = list.children.length > 0;
}

function addTask(taskText) {
  const item = document.createElement("li");

  const checkbox = document.createElement("input");
  checkbox.type = "checkbox";
  checkbox.setAttribute("aria-label", "Mark task as complete");

  const text = document.createElement("span");
  text.textContent = taskText;

  const deleteButton = document.createElement("button");
  deleteButton.type = "button";
  deleteButton.className = "delete-button";
  deleteButton.textContent = "Delete";
  deleteButton.addEventListener("click", () => {
    item.remove();
    updateEmptyMessage();
  });

  checkbox.addEventListener("change", () => {
    item.classList.toggle("done", checkbox.checked);
  });

  item.append(checkbox, text, deleteButton);
  list.appendChild(item);
  updateEmptyMessage();
}

form.addEventListener("submit", (event) => {
  event.preventDefault();
  const taskText = input.value.trim();
  if (!taskText) return;
  addTask(taskText);
  input.value = "";
  input.focus();
});

clearButton.addEventListener("click", () => {
  list.replaceChildren();
  updateEmptyMessage();
});

updateEmptyMessage();
