using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AdjustIntensity : MonoBehaviour
{

    [SerializeField]
    private float maxIntensity;

    [SerializeField]
    private float speed;

    [SerializeField]
    private float maxRange;

    Light myLight;
    float initialIntensity;
    float initialRange;

    // Start is called before the first frame update
    void Start()
    {
        myLight = GetComponent<Light>();
        myLight.intensity = Random.Range(0f, 15f); 
        myLight.range = Random.Range(10f, maxRange);
        initialIntensity = myLight.intensity;
        initialRange = myLight.range;
    }

    // Update is called once per frame
    void Update()
    {
        myLight.intensity = initialIntensity + Mathf.PingPong(Time.time * speed, maxIntensity - initialIntensity);
        myLight.range = initialRange + Mathf.PingPong(Time.time * 10f * speed, maxRange - initialRange) + 50f;
    }
}
