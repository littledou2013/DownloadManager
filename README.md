# DownloadManager
下载管理器下载管理器 思路:

1.实现 单个任务的下载

    - 实现downloadWithURL 方法.下载单个任务
        - 检查服务器上的文件大小
        - 检查本地文件大小!
        - 从服务器开始下载!
    - 从服务器下 实现downloadFile(主线程)
        - 通过Connection的代理方法进行下载
    - 通过Runloop开启异步下载

    - 通过Block通知调用者
        需要扩展:通知调用者下载的相关信息
        *  1.进度,通知百分比
        *  2.是否完成,通知下载保存的路径
        *  3.错误,通知错误信息
        downloadWithURL:(NSURL *)url Progress:(void (^)(float progress))progress completion:(void (^)(NSString * filePath))completion failed:(void (^)(NSString * errorMsg))failed

    - 实现暂停操作!
        通过connection的引用取消我们的连接

2.实现 多个任务的下载

    - 仿照AFN 抽取单例对象(Manager)对网络任务进行管理
        LDDownloaderManager
    - 定义一个下载操作的缓冲池!是用字典保存"下载对象"和"URL"的键值
        /** 下载操作的缓冲池  */
        @property(nonatomic,strong)NSMutableDictionary * downloaderCache;
        - 下载完毕和下载失败我们需要冲缓冲池删除这个下载操作 利用Block通知外界
    - 暂停操作
       

