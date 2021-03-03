## 2021-01-16
- unity doc
- package
  - 2d animation
  - 2d pixel perfect
  - addressable(local and remote asset management, alternative to AssetBundle?)
  - burst compiler
  - cinemachine (camera controlling)
  - HDRP
  - post process
  - pro builder
  - quick search(Alt+)(can be added from Package Manager)
  - scriptable build pipeline
  - shader graph
  - URP
  - Visual Effect Graph
- interface
  - log -> right-top corner -> lines of entry
- AssetBundle
  - BuildPipeline.BuildAssetBundle()
  - AssetBundle.LoadFromFile()
  - BuildAssetBundleOption
    - None(LZMA compression)
    - UncompressedAssetBundle(no compression)
    - ChunkBasedCompression(LZ4 compression)