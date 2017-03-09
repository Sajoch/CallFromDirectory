#include <string>
#include <windows.h>

#pragma comment(lib,"user32.lib")
#pragma comment(lib,"shell32.lib")

int CALLBACK WinMain(
  _In_ HINSTANCE hInstance,
  _In_ HINSTANCE hPrevInstance,
  _In_ LPSTR     lpCmdLine,
  _In_ int       nCmdShow
){
  std::wstring msys2_path;
  std::wstring current_path;
  LPWSTR* argv;
  int argc;
  argv = CommandLineToArgvW(GetCommandLineW(), &argc);
  if (argv == NULL){
    MessageBoxW(NULL, L"Unable to parse command line", L"Error", MB_OK);
    return 10;
  }
  if(argc != 3){
    MessageBoxW(NULL, L"Using: <msys2.exe> <current_dir>", L"Error", MB_OK);
    return 1;
  }
  msys2_path = argv[1];
  current_path = argv[2];
  LocalFree(argv);

  STARTUPINFOW si;
  PROCESS_INFORMATION pi;
  ZeroMemory(&si, sizeof(STARTUPINFOW));
  ZeroMemory(&pi, sizeof(PROCESS_INFORMATION));
  if(CreateProcessW(NULL, (wchar_t*)msys2_path.data(), NULL, NULL, FALSE, 0,
    NULL, current_path.c_str(), &si, &pi)){
      return 0;
  }
  return 1;
}
