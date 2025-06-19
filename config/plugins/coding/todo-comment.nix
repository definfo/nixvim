{ mylib, ... }:
{
  plugins.todo-comments = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
