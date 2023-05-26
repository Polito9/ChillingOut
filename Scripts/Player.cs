using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class Player : MonoBehaviour
{
    public float offsetBullet;
    public GameObject bulletPrefab;

    private Rigidbody2D rb;
    public float maxSpeed;
    private float vertical;
    private float horizontal;
    private bool shooting;
    public float aceleration;
    public float drag;
    public float angularSpeed;
    private bool canShoot;
    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        rb.drag = drag;
    }

    // Update is called once per frame
    void Update()
    {
        vertical = InputManager.vertical;
        horizontal = InputManager.horizontal;
        shooting = InputManager.Fire;
        rotate();
        shoot();
    }
    private void FixedUpdate()
    {
        var forwardMotor = Mathf.Clamp(vertical, 0f, 1f);
        rb.AddForce(transform.up * aceleration * forwardMotor);
        if (rb.velocity.magnitude > maxSpeed)
        {
            rb.velocity = rb.velocity.normalized * maxSpeed;
        }
    }
    private void rotate()
    {
        if (horizontal == 0)
        {
            return;
        }
        transform.Rotate(0, 0, -angularSpeed * horizontal * Time.deltaTime);
    }
    private void shoot()
    {
        if (shooting && canShoot)
        {
            //StartCoroutine(FireRate());
        }
    }
    /*
    private IEnumerator FireRate()
    {
        canShoot = false;
        var pos = transform.up * offsetBullet + transform.position;
        var bullet = Instantiate(
            bulletPrefab, pos, transform.rotation
            );
        Destroy(bullet, 5);
        canShoot = false;
    }*/
}
