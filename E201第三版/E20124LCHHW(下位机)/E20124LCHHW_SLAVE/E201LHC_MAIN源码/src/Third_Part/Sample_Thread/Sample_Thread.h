#ifndef __SP_THREAD_H__
#define __SP_THREAD_H__

typedef unsigned short line_t;

#define LINE_INIT(s) s = 0;

#define LINE_RESUME(s) switch(s) { case 0:

#define LINE_SET(s) s = __LINE__;case __LINE__:

#define LINE_END(s) }



typedef struct  
{
 char line;
}
spthd;

#define SP_WAITING 0
#define SP_EXITED  1
#define SP_ENDED   2
#define SP_YIELDED 3

/**
 * \name Initialization
 * @{
 */

/**
 * Initialize a protothread.
 *
 * Initializes a protothread. Initialization must be done prior to
 * starting to execute the protothread.
 *
 * \param sp A pointer to the protothread control structure.
 *
 * \sa SP_SPAWN()
 *
 * \hideinitializer
 */
#define SP_INIT(sp)   LINE_INIT((sp)->line)

/** @} */

/**
 * \name Declaration and definition
 * @{
 */

/**
 * Declaration of a protothread.
 *
 * This macro is used to declare a protothread. All protothreads must
 * be declared with this macro.
 *
 * \param name_args The name and arguments of the C function
 * implementing the protothread.
 *
 * \hideinitializer
 */
#define SP_THREAD(name_args) char name_args

/**
 * Declare the start of a protothread inside the C function
 * implementing the protothread.
 *
 * This macro is used to declare the starting point of a
 * protothread. It should be placed at the start of the function in
 * which the protothread runs. All C statements above the SP_BEGIN()
 * invokation will be executed each time the protothread is scheduled.
 *
 * \param sp A pointer to the protothread control structure.
 *
 * \hideinitializer
 */
#define SP_BEGIN(sp) { char SP_YIELD_FLAG = 1; LINE_RESUME((sp)->line)

/**
 * Declare the end of a protothread.
 *
 * This macro is used for declaring that a protothread ends. It must
 * always be used together with a matching SP_BEGIN() macro.
 *
 * \param sp A pointer to the protothread control structure.
 *
 * \hideinitializer
 */
#define SP_END(sp) LINE_END((sp)->line); SP_YIELD_FLAG = 0; \
                   SP_INIT(sp); return SP_ENDED; }

/** @} */

/**
 * \name Blocked wait
 * @{
 */

/**
 * Block and wait until condition is true.
 *
 * This macro blocks the protothread until the specified condition is
 * true.
 *
 * \param sp A pointer to the protothread control structure.
 * \param condition The condition.
 *
 * \hideinitializer
 */
#define SP_WAIT_UNTIL(sp, condition)	        \
  do {						\
    LINE_SET((sp)->line);				\
    if(!(condition)) {				\
      return SP_WAITING;			\
    }						\
  } while(0)

/**
 * Block and wait while condition is true.
 *
 * This function blocks and waits while condition is true. See
 * SP_WAIT_UNTIL().
 *
 * \param sp A pointer to the protothread control structure.
 * \param cond The condition.
 *
 * \hideinitializer
 */
#define SP_WAIT_WHILE(sp, cond)  SP_WAIT_UNTIL((sp), !(cond))

/** @} */

/**
 * \name Hierarchical protothreads
 * @{
 */

/**
 * Block and wait until a child protothread completes.
 *
 * This macro schedules a child protothread. The current protothread
 * will block until the child protothread completes.
 *
 * \note The child protothread must be manually initialized with the
 * SP_INIT() function before this function is used.
 *
 * \param sp A pointer to the protothread control structure.
 * \param thread The child protothread with arguments
 *
 * \sa SP_SPAWN()
 *
 * \hideinitializer
 */
#define SP_WAIT_THREAD(sp, thread) SP_WAIT_WHILE((sp), SP_SCHEDULE(thread))

/**
 * Spawn a child protothread and wait until it exits.
 *
 * This macro spawns a child protothread and waits until it exits. The
 * macro can only be used within a protothread.
 *
 * \param sp A pointer to the protothread control structure.
 * \param child A pointer to the child protothread's control structure.
 * \param thread The child protothread with arguments
 *
 * \hideinitializer
 */
#define SP_SPAWN(sp, child, thread)		\
  do {						\
    SP_INIT((child));				\
    SP_WAIT_THREAD((sp), (thread));		\
  } while(0)

/** @} */

/**
 * \name Exiting and restarting
 * @{
 */

/**
 * Restart the protothread.
 *
 * This macro will block and cause the running protothread to restart
 * its execution at the place of the SP_BEGIN() call.
 *
 * \param sp A pointer to the protothread control structure.
 *
 * \hideinitializer
 */
#define SP_RESTART(sp)				\
  do {						\
    SP_INIT(sp);				\
    return SP_WAITING;			\
  } while(0)

/**
 * Exit the protothread.
 *
 * This macro causes the protothread to exit. If the protothread was
 * spawned by another protothread, the parent protothread will become
 * unblocked and can continue to run.
 *
 * \param sp A pointer to the protothread control structure.
 *
 * \hideinitializer
 */
#define SP_EXIT(sp)				\
  do {						\
    SP_INIT(sp);				\
    return SP_EXITED;			\
  } while(0)

/** @} */

/**
 * \name Calling a protothread
 * @{
 */

/**
 * Schedule a protothread.
 *
 * This function shedules a protothread. The return value of the
 * function is non-zero if the protothread is running or zero if the
 * protothread has exited.
 *
 * \param f The call to the C function implementing the protothread to
 * be scheduled
 *
 * \hideinitializer
 */
#define SP_SCHEDULE(f) ((f) == SP_WAITING)

/** @} */

/**
 * \name Yielding from a protothread
 * @{
 */

/**
 * Yield from the current protothread.
 *
 * This function will yield the protothread, thereby allowing other
 * processing to take place in the system.
 *
 * \param sp A pointer to the protothread control structure.
 *
 * \hideinitializer
 */
#define SP_YIELD(sp)				\
  do {						\
    SP_YIELD_FLAG = 0;				\
    LINE_SET((sp)->line);				\
    if(SP_YIELD_FLAG == 0) {			\
      return SP_YIELDED;			\
    }						\
  } while(0)

/**
 * \brief      Yield from the protothread until a condition occurs.
 * \param sp   A pointer to the protothread control structure.
 * \param cond The condition.
 *
 *             This function will yield the protothread, until the
 *             specified condition evaluates to true.
 *
 *
 * \hideinitializer
 */
#define SP_YIELD_UNTIL(sp, cond)		\
  do {						\
    SP_YIELD_FLAG = 0;				\
    LINE_SET((sp)->line);				\
    if((SP_YIELD_FLAG == 0) || !(cond)) {	\
      return SP_YIELDED;			\
    }						\
  } while(0)



#endif /* __SP_H__ */


