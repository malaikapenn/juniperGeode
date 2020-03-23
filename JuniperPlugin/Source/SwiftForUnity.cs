using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class SwiftForUnity : MonoBehaviour
{
    #region Declare external C interface

#if UNITY_IOS && !UNITY_EDITOR

    [DllImport("__Internal")]
    private static extern void _setupAccessoryList();

    [DllImport("__Internal")]
    private static extern bool _isAccessory();

    [DllImport("__Internal")]
    private static extern void _connect();

    [DllImport("__Internal")]
    private static extern void _disconnect();
    
#endif

    #endregion

    #region Wrapped methods and properties

    public static void setupAccessoryList()
    {
#if UNITY_IOS && !UNITY_EDITOR
        _setupAccessoryList();
#endif
    }

    public static bool IsAccessory()
    {
#if UNITY_IOS && !UNITY_EDITOR
        return _isAccessory();
#else
        return false;
#endif
    }

    public static void connect()
    {
#if UNITY_IOS && !UNITY_EDITOR
        _connect();
#endif
    }

    public static void disconnect()
    {
#if UNITY_IOS && !UNITY_EDITOR
        _disconnect();
#endif
    }

    #endregion

    #region Singleton implementation

    private static SwiftForUnity _instance;

    public static SwiftForUnity Instance
    {
        get
        {
            if (_instance == null)
            {
                var obj = new GameObject("SwiftUnity");
                _instance = obj.AddComponent<SwiftForUnity>();
            }

            return _instance;
        }
    }

    private void Awake()
    {
        if (_instance != null)
        {
            Destroy(gameObject);
            return;
        }

        DontDestroyOnLoad(gameObject);
    }

    #endregion
}