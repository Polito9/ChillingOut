using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Asteroid : MonoBehaviour
{
    private Rigidbody2D body;
    public float speed;
    // Start is called before the first frame update
    void Start()
    {
        body = GetComponent<Rigidbody2D>();
        body.drag = 0;
        body.angularDrag = 0;
        body.velocity = new Vector3(
            Random.Range(-1f, 1f),
            Random.Range(-1f, 1f),
            0).normalized *speed;
        //Normalized es para solo obtener la dirección.
        body.angularVelocity = Random.Range(-50f, 50f);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
